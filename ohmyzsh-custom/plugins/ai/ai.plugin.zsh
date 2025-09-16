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

