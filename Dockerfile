
FROM python:3.11-slim AS builder  
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim AS production


RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser   #  Create a non-root user and group for security pero essta abier a a vulnerabilidad de seguridad, se recomienda usar un usuario no root para ejecutar la aplicación

WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY . .

RUN chown -R appuser:appgroup /app /usr/local/lib/python3.11/site-packages
USER appuser


EXPOSE 5000
CMD ["python", "app.py"]