{{/*
Expand the name of the chart.
*/}}
{{- define "novu-chart.api.name" -}}
{{- default (print .Chart.Name "-api") .Values.api.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "novu-chart.api.fullname" -}}
{{- if .Values.api.fullnameOverride }}
{{- .Values.api.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (print .Chart.Name "-api") .Values.api.nameOverride }}
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
{{- define "novu-chart.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "novu-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}

{{- define "novu-chart.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "novu-chart.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}
