-- return {
--   Meta = function(meta)
--     local function coalesce_bool(m, keys)
--       for _, k in ipairs(keys) do
--         if m[k] ~= nil then
--           local v = m[k]
--           local t = pandoc.utils.type(v)
--           if t == 'MetaBool' then
--             return v
--           elseif t == 'MetaString' then
--             local s = pandoc.utils.stringify(v):lower()
--             if s == 'true' then return true end
--             if s == 'false' then return false end
--           end
--         end
--       end
--       return nil
--     end

--     local val = coalesce_bool(meta, { 'mostrar-cabecera', 'show-cabecera' })
--     if val == nil then val = true end
--     meta['show-cabecera-effective'] = pandoc.MetaString(tostring(val))
--     return meta
--   end
-- }


-- Coalescencia booleana robusta para mostrar/ocultar cabecera
local function coalesce_bool(meta, keys)
  for _, k in ipairs(keys) do
    if meta[k] ~= nil then
      local s = pandoc.utils.stringify(meta[k]):lower()
      if s == 'true' then return true end
      if s == 'false' then return false end
    end
  end
  return nil
end

-- Extrae una ruta de un valor de `logo`: string tal cual o tabla de
-- normalización de Quarto (variantes light/dark con `path`). Devuelve el
-- primer string no vacío o nil si no hay nada aprovechable.
local function logo_path(v, depth)
  depth = depth or 0
  if v == nil or depth > 5 then return nil end
  if type(v) == 'string' then
    return (v ~= '' and v) or nil
  end
  if type(v) ~= 'table' then
    local ok, s = pcall(pandoc.utils.stringify, v)
    if ok and type(s) == 'string' and s ~= '' then return s end
    return nil
  end
  for _, k in ipairs({'light', 'dark', 'path', 1}) do
    local r = logo_path(v[k], depth + 1)
    if r ~= nil then return r end
  end
  for _, vv in pairs(v) do
    local r = logo_path(vv, depth + 1)
    if r ~= nil then return r end
  end
  return nil
end

local function escudo_vacio(meta)
  local e = meta['escudo']
  if e == nil then return true end
  return pandoc.utils.stringify(e) == ''
end

return {
  Meta = function(meta)
    -- Prioridad: mostrar-cabecera (aunque sea false) > show-cabecera > por defecto true
    local val = coalesce_bool(meta, { 'mostrar-cabecera', 'show-cabecera' })
    if val == nil then val = true end
    meta['show-cabecera-effective'] = pandoc.MetaString(tostring(val))
    -- `logo` es clave nativa de Quarto (fondo de página estructurado con
    -- variantes light/dark): un string llega como tabla y la plantilla lo
    -- vería como booleano ("true"), rompiendo la cabecera. Para la cabecera
    -- del examen se usa `escudo`: si hay `logo` pero no `escudo`, se migra;
    -- en todo caso se retira `logo` cuando la cabecera se va a mostrar,
    -- para que ni rompa la cabecera ni duplique el logo con el fondo nativo.
    if meta['logo'] ~= nil then
      io.stderr:write("[examtypst] aviso: 'logo' es una clave nativa de Quarto y no funciona como ruta en la cabecera; usa 'escudo' en su lugar.\n")
      if val and escudo_vacio(meta) then
        local r = logo_path(meta['logo'])
        if r ~= nil and r ~= '' then
          meta['escudo'] = pandoc.MetaString(r)
        end
      end
      if val then meta['logo'] = nil end
    end
    return meta
  end
}