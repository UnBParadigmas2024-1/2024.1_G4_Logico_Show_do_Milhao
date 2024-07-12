FROM swipl:latest

WORKDIR /app

COPY . /app

EXPOSE 8080

CMD ["swipl", "show_do_milhao_web.pl"]
