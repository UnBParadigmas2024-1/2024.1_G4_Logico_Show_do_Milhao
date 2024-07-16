FROM swipl:latest

# Instalar tini
RUN apt-get update && apt-get install -y tini

WORKDIR /app

COPY . /app

EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["swipl", "show_do_milhao_web.pl"]
