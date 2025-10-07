-- Filtro para validar parámetros obligatorios
function Meta(meta)
  local warnings = {}
  local errors = {}
  
  -- Parámetros recomendados
  local recommended = {
    "department",
    "subject",
    "degree",
    "exam-type",
    "exam-date"
  }
  
  -- Verificar parámetros recomendados
  for _, param in ipairs(recommended) do
    --local key = param:gsub("-", "_")
    local key = param 
    if not meta[key] or pandoc.utils.stringify(meta[key]) == "" then
      table.insert(warnings, string.format(
        "⚠️  Parámetro recomendado '%s' no especificado", param
      ))
    end
  end
  
  -- Validar valores específicos
  if meta.show_solutions then
    local val = pandoc.utils.stringify(meta.show_solutions)
    if val ~= "true" and val ~= "false" then
      table.insert(errors, string.format(
        "❌ 'show-solutions' debe ser 'true' o 'false', recibido: '%s'", val
      ))
    end
  end
  
  if meta.fontsize then
    local size = tonumber(pandoc.utils.stringify(meta.fontsize))
    if not size or size < 8 or size > 16 then
      table.insert(warnings, string.format(
        "⚠️  'fontsize' fuera del rango recomendado (8-16pt): %s", 
        pandoc.utils.stringify(meta.fontsize)
      ))
    end
  end
  
  -- Validar tema si está presente
  if meta.theme and meta.theme.primary then
    local color = pandoc.utils.stringify(meta.theme.primary)
    if not color:match("^#%x%x%x%x%x%x$") then
      table.insert(warnings, string.format(
        "⚠️  Color 'theme.primary' no parece válido: '%s'", color
      ))
    end
  end
  
  -- Validar idioma
  if meta.lang then
    local lang = pandoc.utils.stringify(meta.lang)
    local valid_langs = {es = true, en = true, fr = true, de = true, pt = true}
    if not valid_langs[lang] then
      table.insert(warnings, string.format(
        "⚠️  Idioma '%s' no soportado oficialmente. Soportados: es, en, fr, de, pt", 
        lang
      ))
    end
  end
  
  -- Mostrar errores y warnings
  if #errors > 0 then
    io.stderr:write("\n=== ERRORES DE VALIDACIÓN ===\n")
    for _, err in ipairs(errors) do
      io.stderr:write(err .. "\n")
    end
    io.stderr:write("=============================\n\n")
  end
  
  -- if #warnings > 0 then
  --   io.stderr:write("\n=== ADVERTENCIAS ===\n")
  --   for _, warn in ipairs(warnings) do
  --     io.stderr:write(warn .. "\n")
  --   end
  --   io.stderr:write("====================\n\n")
  -- end
  
  return meta
end