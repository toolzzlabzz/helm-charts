{{/*
Expand the name of the chart.
*/}}
{{- define "novu.widget.name" -}}
{{- default (print .Chart.Name "-widget") .Values.widget.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "novu.widget.fullname" -}}
{{- if .Values.widget.fullnameOverride }}
{{- .Values.widget.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (print .Chart.Name "-widget") .Values.widget.nameOverride }}
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
{{- define "novu.widget.selectorLabels" -}}
app.kubernetes.io/name: {{ include "novu.widget.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}

{{- define "novu.widget.serviceAccountName" -}}
{{- if .Values.widget.serviceAccount.create }}
{{- default (include "novu.widget.fullname" .) .Values.widget.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.widget.serviceAccount.name }}
{{- end }}
{{- end }}
