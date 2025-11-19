function audio-to-text() {
    local input="$1"
    local lang="${2:-es}"
    whisper "$input" --model small --language "$lang" --output_format txt
}

function video-to-text() {

  if [[ -z "$1" ]]; then
    echo "Uso: yt-video-to-text <URL> [IDIOMA] [OUTPUT_FILE]"
    echo "  URL         -> URL del video (YouTube, TikTok, Instagram)"
    echo "  IDIOMA      -> Idioma para Whisper (por defecto: es)"
    echo "  OUTPUT_FILE -> Nombre base de salida (sin extensión, por defecto: yt_video)"
    return 1
  fi

  local url="$1"
  local lang="${2:-es}"                     # idioma por defecto
  local output_file="${3:-yt_video}"        # nombre base de salida
  local audio_file="${output_file}.mp3"     # archivo de audio generado

  echo "🔽 Descargando audio del video en MP3..."
  yt-dlp --audio-quality 320K -x --audio-format mp3 -o "$audio_file" "$url"

  echo "📝 Transcribiendo con Whisper..."
  whisper "$audio_file" --model small --language "$lang" --output_format txt --output_dir .

  # Limpiar archivo temporal
  rm "$audio_file"

  echo "✅ Transcripción generada: ${audio_file}.txt"
}


function video-local-to-text() {

  if [[ -z "$1" ]]; then
    echo "Uso: video-local-to-text <VIDEO_FILE> [IDIOMA] [OUTPUT_FILE]"
    echo "  VIDEO_FILE  -> Archivo de video local (mp4, mov, mkv, etc.)"
    echo "  IDIOMA      -> Idioma para Whisper (por defecto: es)"
    echo "  OUTPUT_FILE -> Nombre base de salida (sin extensión, por defecto: local_video)"
    return 1
  fi

  local video_file="$1"
  local lang="${2:-es}"                      # idioma por defecto
  local output_file="${3:-local_video}"      # nombre base de salida
  local audio_file="${output_file}.mp3"      # archivo de audio generado

  # Extraer audio a MP3 desde el video local
  echo "🔽 Extrayendo audio de $video_file a MP3..."
  ffmpeg -y -i "$video_file" -vn -acodec libmp3lame -ar 44100 -ac 2 "$audio_file"

  # Transcribir con Whisper
  echo "📝 Transcribiendo con Whisper..."
  whisper "$audio_file" --model small --language "$lang" --output_format txt --output_dir .

  # Limpiar archivo temporal
  rm "$audio_file"

  echo "✅ Transcripción generada: ${output_file}.txt"
}

copilot_here() {
  # --- SECURITY CHECK ---
  # 1. Ensure the 'copilot' scope is present using a robust grep check.
  if ! gh auth status 2>/dev/null | grep "Token scopes:" | grep -q "'copilot'"; then
    echo "❌ Error: Your gh token is missing the required 'copilot' scope."
    echo "Please run 'gh auth refresh -h github.com -s copilot' to add it."
    return 1
  fi

  # 2. Warn if the token has highly privileged scopes.
  if gh auth status 2>/dev/null | grep "Token scopes:" | grep -q -E "'(admin:|manage_|write:public_key|delete_repo|(write|delete)_packages)'"; then
    echo "⚠️  Warning: Your GitHub token has highly privileged scopes (e.g., admin:org, admin:enterprise)."
    printf "Are you sure you want to proceed with this token? [y/N]: "
    read confirmation
    local lower_confirmation
    lower_confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')
    if [[ "$lower_confirmation" != "y" && "$lower_confirmation" != "yes" ]]; then
      echo "Operation cancelled by user."
      return 1
    fi
  fi
  # --- END SECURITY CHECK ---

  # Define the image name for easy reference
  local image_name="ghcr.io/gordonbeeming/copilot_here:latest"

  # Pull the latest version of the image, showing a spinner for feedback.
  printf "Checking for the latest version of copilot_here... "
  
  # Run docker pull in the background and capture its process ID (PID)
  (docker pull "$image_name" > /dev/null 2>&1) &
  local pull_pid=$!
  local spin='|/-\'
  
  # While the pull process is running, display a spinner
  local i=0
  while ps -p $pull_pid > /dev/null; do
    i=$(( (i+1) % 4 ))
    # Print the spinner character, then move the cursor back
    printf "%s\b" "${spin:$i:1}"
    sleep 0.1
  done

  # Wait for the process to finish and get its exit code
  wait $pull_pid
  local pull_status=$?
  
  # Replace the spinner with a final status and add a newline
  if [ $pull_status -eq 0 ]; then
    echo "✅"
  else
    echo "❌"
    echo "Error: Failed to pull the Docker image. Please check your Docker setup and network."
    return 1
  fi

  # Define path for our persistent copilot config on the host machine.
  local copilot_config_path="$HOME/.config/copilot-cli-docker"
  mkdir -p "$copilot_config_path"

  # Use the 'gh' CLI itself to reliably get the current auth token.
  local token=$(gh auth token 2>/dev/null)
  if [ -z "$token" ]; then
    echo "⚠️  Could not retrieve token using 'gh auth token'. Please ensure you are logged in."
  fi

  # Base Docker command arguments
  local docker_args=(
    --rm -it
    -v "$(pwd)":/work
    -v "$copilot_config_path":/home/appuser/.copilot
    -e PUID=$(id -u)
    -e PGID=$(id -g)
    -e GITHUB_TOKEN="$token"
    "$image_name"
  )

  if [ $# -eq 0 ]; then
    # No arguments provided, start interactive mode with the banner.
    docker run "${docker_args[@]}" copilot --banner --allow-all-tools
  else
    # Arguments provided, run in non-interactive (but safe) mode.
    docker run "${docker_args[@]}" copilot -p "$*"
  fi
}

