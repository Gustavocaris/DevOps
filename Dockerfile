# Use uma imagem base oficial do Python. A tag 'slim' é um bom compromisso entre tamanho e ter as ferramentas necessárias.
FROM python:3.11-slim

# Define o diretório de trabalho no contêiner para /app
WORKDIR /app

# Impede o Python de gerar arquivos .pyc e o mantém rodando em modo sem buffer
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copia o arquivo de dependências primeiro. Isso aproveita o cache do Docker.
# A camada de instalação de dependências só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que a aplicação irá rodar (padrão do uvicorn é 8000)
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]