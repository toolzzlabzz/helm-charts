{{/*
Expand the name of the chart.
*/}}
{{- define "novu-chart.worker.name" -}}
{{- default (print .Chart.Name "-worker") .Values.worker.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "novu-chart.worker.fullname" -}}
{{- if .Values.worker.fullnameOverride }}
{{- .Values.worker.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (print .Chart.Name "-worker") .Values.worker.nameOverride }}
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
{{- define "novu-chart.worker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "novu-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}

{{- define "novu-chart.worker.serviceAccountName" -}}
{{- if .Values.worker.serviceAccount.create }}
{{- default (include "novu-chart.worker.fullname" .) .Values.worker.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.worker.serviceAccount.name }}
{{- end }}
{{- end }}
