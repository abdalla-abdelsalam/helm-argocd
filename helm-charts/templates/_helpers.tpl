{{/* helpers.tpl */}}


{{- define "myapp.fullname" -}}
{{- printf "%s-%s" .Release.Name "myapp" }}
{{- end -}}

{{- define "myapp.name" -}}
{{- printf "myapp" }}
{{- end -}}