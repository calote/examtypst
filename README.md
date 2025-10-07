# examtypst - Extensión Quarto para crear exámenes con Typst

Extensión de Quarto que facilita la creación de exámenes académicos profesionales usando Typst desde RStudio o Positron.

## 🚀 Instalación

```bash
quarto add calote/examtypst
```

## ✨ Características

- ✅ Cabecera institucional personalizable con logo
- ✅ Numeración automática de ejercicios
- ✅ Soluciones ocultas/visibles con un parámetro
- ✅ Preguntas de opción múltiple
- ✅ Preguntas verdadero/falso
- ✅ Espacios para desarrollo
- ✅ Tabla de calificaciones
- ✅ Datos del estudiante
- ✅ Soporte multiidioma (ES, EN, FR, DE, PT)
- ✅ 5 temas predefinidos personalizables
- ✅ Validación automática de parámetros
- ✅ Scripts para generar examen y soluciones por separado

## 📖 Uso Básico

```yaml
---
title: "Examen Final"
format:
  examtypst-typst:
    department: "Departamento de Matemáticas"
    subject: "Álgebra Lineal"
    degree: "Grado en Matemáticas"
    exam-type: "Final"
    exam-date: "20 de Junio de 2025"
    show-solutions: false
    theme-preset: "modern"
    lang: "es"
---
```

## Uso de Parámetros YAML en Español y en Inglés

Se pueden usar tanto los nombres en inglés como en español (tiene prioridad) para los parámetros en la cabecera YAML. El mapeo completo de parámetros es el siguiente:

Inglés |	Español
-------|-------
department |	departamento
subject |	asignatura
degree	| titulacion
exam-type	| tipo-examen
exam-date	| fecha-examen
show-solutions	| mostrar-soluciones
show-student-data	| mostrar-datos-estudiante
show-cabecera	| mostrar-cabecera
show-ejercicio-cuadro	| mostrar-ejercicio-cuadro
additional-fields	| campos-adicionales
ejercicio-nombre	| nombre-ejercicio
exercise-line-break | ejercicio-salto-linea
lang	| idioma
logo  | escudo






## 📝 Tipos de Ejercicios

### Ejercicio Básico

```markdown
:::{.ejercicio}
Resuelve la ecuación: $x^2 - 5x + 6 = 0$

:::{.solucion}
Las soluciones son $x_1 = 2$ y $x_2 = 3$
:::
:::
```

### Ejercicio con Puntuación

```markdown
:::{.ejercicio arguments='puntos: 3.5'}
Deriva la siguiente función...
:::
```

### Ejercicio con Apartados

```markdown
:::{.ejercicio arguments='puntos: 4'}

:::{.apartado}
Apartado a) Primera parte...
:::

:::{.apartado arguments='letra: "b"'}
Apartado b) Segunda parte...
:::
:::
```

### Opción Múltiple

```markdown
:::{.pregunta-multiple arguments='correcta: 2, columnas: 2, opciones: (
  "Madrid",
  "Londres",
  "París",
  "Berlín"
)'}
¿Cuál es la capital de Francia?

:::
```

### Verdadero/Falso

```markdown
:::{.verdadero-falso arguments='correcta: true'}
La Tierra es redonda.
:::
```

### Espacio para Desarrollo

```markdown
:::{.espacio-desarrollo arguments='lineas: 8, puntos: true'}
:::
```

## 🎨 Temas Disponibles

- `classic` - Tema tradicional universitario (por defecto)
- `modern` - Tema contemporáneo con colores vibrantes
- `green` - Tema con tonos verdes relajantes
- `purple` - Tema elegante en tonos morados
- `dark` - Tema oscuro para impresión económica

```yaml
format:
  examtypst-typst:
    theme-preset: "modern"
```

### Tema Personalizado

```yaml
format:
  examtypst-typst:
    theme:
      primary: "#2563eb"
      secondary: "#7c3aed"
      background: "#f1f5f9"
      solution-bg: "#ddd6fe"
      solution-border: "#7c3aed"
```

## 🌍 Idiomas Soportados

- `es` - Español (por defecto)
- `en` - Inglés
- `fr` - Francés
- `de` - Alemán
- `pt` - Portugués

```yaml
format:
  examtypst-typst:
    lang: "en"
```

## 🔄 Generar Examen y Soluciones

### Bash/Linux/Mac

Sin soluciones activadas:

```bash
quarto render template.qmd --to examtypst-typst \
  -M mostrar-soluciones:false \
  -M output-file:template.pdf
```

```bash
quarto render template.qmd --to examtypst-typst -M mostrar-soluciones:false -M output-file:template.pdf
```



Con soluciones activadas:

```bash
quarto render template.qmd --to examtypst-typst \
  -M mostrar-soluciones:true \
  -M output-file:template-sol.pdf
```

## 📋 Ejemplos

Ver carpeta `tests/` para ejemplos completos:

- `ejemplo-basico.qmd` - Examen básico
- `ejemplo-completo.qmd` - Examen con todas las características
- `ejemplo-matematicas.qmd` - Examen de matemáticas
- `ejemplo-test.qmd` - Examen tipo test

## 🛠️ Configuración Avanzada

### Datos del Estudiante

```yaml
format:
  examtypst-typst:
    show-student-data: true
```

### Logo Personalizado

```yaml
format:
  examtypst-typst:
    logo: "ruta/a/mi-logo.png"
```

### Ocultar Cuadros de Ejercicios

```yaml
format:
  examtypst-typst:
    show-ejercicio-cuadro: false
```

### Personalizar Nombre de "Ejercicio"

```yaml
format:
  examtypst-typst:
    ejercicio-nombre: "Problema"
```

## ⚙️ Requisitos

- Quarto >= 1.6.0
- Typst instalado
- R (opcional, para scripts de automatización)

## 📄 Licencia

MIT License

## 👤 Autor

Pedro Luque

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request en el repositorio.

## 📚 Documentación Adicional

Para más información sobre las funciones disponibles y opciones de configuración, consulta los archivos de ejemplo en la carpeta `tests/`.

## ⚠️ Solución de Problemas

### Error: Logo no encontrado

Asegúrate de que el archivo `logo.png` existe en el directorio del documento o especifica la ruta correcta:

```yaml
logo: "ruta/completa/logo.png"
```

### Las soluciones no se muestran/ocultan

Verifica que el parámetro `show-solutions` esté correctamente establecido:

```yaml
show-solutions: false  # Para ocultar
show-solutions: true   # Para mostrar
```

### Error de compilación Typst

Asegúrate de tener Typst instalado:

```bash
# Verificar instalación
quarto typst --version

# Instalar Typst (si no está instalado)
# Ver: https://github.com/typst/typst
```

## 📞 Soporte

Para reportar bugs o solicitar nuevas características, abre un issue en el repositorio.