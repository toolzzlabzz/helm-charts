{{/*
Expand the name of the chart.
*/}}
{{- define "cert-manager-workloads.clusterissuer.name" -}}
{{- default (print .Chart.Name "-clusterissuer") .Values.clusterissuer.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cert-manager-workloads.clusterissuer.fullname" -}}
{{- if .Values.clusterissuer.fullnameOverride }}
{{- .Values.clusterissuer.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (print .Chart.Name "-clusterissuer") .Values.clusterissuer.nameOverride }}
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
{{- define "cert-manager-workloads.clusterissuer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cert-manager-workloads.clusterissuer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}

{{- define "cert-manager-workloads.clusterissuer.serviceAccountName" -}}
{{- if .Values.clusterissuer.serviceAccount.create }}
{{- default (include "cert-manager-workloads.clusterissuer.fullname" .) .Values.clusterissuer.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.clusterissuer.serviceAccount.name }}
{{- end }}
{{- end }}
