{{- define "app-labels" -}}
dashboard-ui: first
{{- end }}

{{- define "image-pull-secrets" -}}
- name: harbor-credentials
{{- end }}

{{- define "env-from-configmap" -}}
- configMapRef:
    name: dashboard-ui-configmap
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
  port: {{ .Values.app.port }}
initialDelaySeconds: 15
periodSeconds: 15
{{- end }}

{{- define "app-configmap" -}}
PORT: "3091"
HOST: "0.0.0.0"
USERS_API_BASE_URL: "http://4.2.1.1.nip.io:30312"
DOCUMENTS_API_BASE_URL: "http://4.2.1.1.nip.io:30312"
{{- end }}