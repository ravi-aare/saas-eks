# docker/Dockerfile
# Multi-stage, minimal Python image
FROM python:3.12-slim AS build
WORKDIR /app
COPY app/app.py /app/app.py
RUN useradd -m appuser
USER appuser

FROM python:3.12-slim
WORKDIR /app
COPY --from=build /app/app.py /app/app.py
USER 1000
EXPOSE 5000
CMD ["python", "app.py"]
