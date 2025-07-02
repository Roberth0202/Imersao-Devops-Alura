# Escolhe uma imagem base enxuta do Python 3.11 para reduzir o tamanho do container
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do container como /app
WORKDIR /app

# Copia apenas o arquivo de dependências para aproveitar o cache do Docker
COPY requirements.txt .

# Instala as dependências Python listadas em requirements.txt
# --no-cache-dir evita armazenar arquivos temporários, economizando espaço
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o restante do código-fonte da aplicação para o diretório de trabalho
COPY . .

# Informa ao Docker que o container irá escutar na porta 8000
EXPOSE 8000

# Comando padrão para iniciar o servidor Uvicorn, executando a aplicação FastAPI
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
