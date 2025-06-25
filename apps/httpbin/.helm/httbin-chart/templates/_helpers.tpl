{{/* Helm template helper for full name */}}
{{- define "httpbin.fullname" -}}
{{- printf "%s" .Chart.Name -}}
{{- end -}}