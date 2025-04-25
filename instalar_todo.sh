#!/bin/bash

# Function to execute a command and check its exit status
execute_command() {
    echo "Executing: $1"
    echo "----------------------------------------"
    eval "$1"
    if [ $? -ne 0 ]; then
        echo "Error: Command failed: $1"
        exit 1
    fi
    echo "----------------------------------------"
}

# Make the script exit on any error
set -e

# 1. Install Ollama
echo "Instalando Ollama..."
execute_command "curl -fsSL https://ollama.com/install.sh | sh"

sleep 3

# 2. Pull Gemma model
echo "Descargando modelo Gemma..."
execute_command "ollama pull gemma3:1b"

# 2.5 Clone the repository
echo "Clonando repositorio..."
execute_command "git clone https://github.com/juliooa/api_llm_privada.git"

# 2.6 Move into the repository directory
execute_command "cd api_llm_privada"

# 3. Install Python venv
echo "Instalando Python venv..."
execute_command "sudo apt install -y python3.12-venv"

# 4. Create virtual environment
echo "Creando entorno virtual..."
execute_command "python3 -m venv venv"

# 5. Activate virtual environment
echo "Activando entorno virtual..."
source venv/bin/activate

# 6. Install requirements
echo "Instalando requerimientos de app..."
execute_command "pip install -r requirements.txt"

# 7. Display IP address and run the application
echo "Tu api está lista, usa la ip de abajo"
echo "IP: $(hostname -I | awk '{print $1}')"
echo "----------------------------------------"

# 8. Run the application
execute_command "python3 app.py"
