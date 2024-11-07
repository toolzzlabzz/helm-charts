{{/*
Expand the name of the chart.
*/}}
{{- define "novu.ws.name" -}}
{{- default (print .Chart.Name "-ws") .Values.ws.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "novu.ws.fullname" -}}
{{- if .Values.ws.fullnameOverride }}
{{- .Values.ws.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (print .Chart.Name "-ws") .Values.ws.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "novu.ws.selectorLabels" -}}
app.kubernetes.io/name: {{ include "novu.ws.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}

{{- define "novu.ws.serviceAccountName" -}}
{{- if .Values.ws.serviceAccount.create }}
{{- default (include "novu.ws.fullname" .) .Values.ws.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ws.serviceAccount.name }}
{{- end }}
{{- end }}
