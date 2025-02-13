{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := .Chart.Name -}}
{{- if contains $name .Release.Name -}}
{{- $.Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "metadata.annotations" -}}
{{- if .Values.annotations }}
{{- tpl (toYaml .Values.annotations) $ }}
{{- end }}
{{- end -}}

{{- define "metadata.labels" -}}
{{- if .Values.extraLabels }}
{{- tpl (toYaml .Values.extraLabels) $ }}
{{- end }}
app.kubernetes.io/part-of: {{ .Release.Namespace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "name" . }}
app.kubernetes.io/version: {{ .Chart.Version }}
{{- end -}}

{{- define "metadata.matchlabels" -}}
app.kubernetes.io/part-of: {{ .Release.Namespace }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "name" . }}
{{- end -}}