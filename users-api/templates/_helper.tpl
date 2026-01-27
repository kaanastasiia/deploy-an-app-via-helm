{{- define "app-labels" -}}
users-api: first
{{- end }}

{{- define "image-pull-secrets" -}}
- name: harbor-credentials
{{- end }}

{{- define "env-from-configmap" -}}
- configMapRef:
    name: users-api-configmap
{{- end }}

{{- define "env-from-secret" -}}
- name: DATABASE_USERNAME
  valueFrom:
    secretKeyRef:
      name: postgres-secret
      key: POSTGRES_USER
- name: DATABASE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: postgres-secret
      key: POSTGRES_PASSWORD
{{- end }}

{{- define "liveness-probe" -}}
tcpSocket:
  port: {{ .Values.service.port }}
initialDelaySeconds: 15
periodSeconds: 15
{{- end }}

{{- define "app-configmap" -}}
DATABASE_NAME: "otus_users_db"
DATABASE_HOST: "postgres"
DATABASE_PORT: "5432"
PORT: "3000"
HOST: "0.0.0.0"
{{- end }}