# examtypst - Extensión Quarto para crear exámenes con Typst y Html

Extensión de Quarto que facilita la creación de exámenes académicos profesionales usando Typst desde RStudio o Positron. Desde la versión 0.3.0 también se soporta salida Html (examtypst-html).


## 🚀 Instalación

```bash
quarto add calote/examtypst
```

O con un fichero quarto de ejemplo:

```bash
quarto use template calote/examtypst
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

### Cabecera YAML de Ejemplo para Typst (uso de parámetros en inglés)

```yaml
---
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


- Ejemplos: PDF con [examtypst-typst](https://raw.githack.com/calote/examtypst/main/template.pdf) y PDF con soluciones activadas [examtypst-typst con soluciones](https://raw.githack.com/calote/examtypst/main/template-sol.pdf)


### Cabecera YAML de Ejemplo para Html (uso de parámetros en español)

Actualmente para el formato examtypst-html no están todas las posibilidades disponibles que sí tiene Typst.

```yaml
---
format:
  examtypst-html:
    mostrar-cabecera: true
    # logo: "logo.png"
    departmento: "Departamento de Matemáticas"
    titulacion: "Grado en Matemáticas"
    asignatura: "Álgebra Lineal"
    tipo-examen: "Final"
    fecha-examen: "20 de Junio de 2025"
    mostrar-soluciones: true
    soluciones-colapsables: true
    color-theme: "default"  # default, blue, green, purple, orange, gray
---
```


- Ejemplo: HTML con [examtypst-html](https://raw.githack.com/calote/examtypst/main/template.html)


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


## 🛠️ Configuración Avanzada

### Datos del Estudiante

```yaml
format:
  examtypst-typst:
    show-student-data: true
```

### Logo Personalizado (escudo)

```yaml
format:
  examtypst-typst:
    escudo: "us.jpg"
```

El fichero se busca junto al documento (p. ej. copiado desde la propia
extensión o desde `source/` de los ejercicios). No uses la clave `logo`:
es una clave nativa de Quarto (fondo de página) y la cabecera del examen
no la entiende (la vería como `true`); si la pones, se traslada a
`escudo` automáticamente con un aviso en la consola.

### Ocultar Cuadros de Ejercicios

```yaml
format:
  examtypst-typst:
    show-ejercicio-cuadro: false
```

### Ocultar la puntuación (relaciones de problemas)

```yaml
format:
  examtypst-typst:
    mostrar-puntos: false  # también vale show-points: false
```

Oculta el `(3 puntos)` del encabezado aunque los bloques lleven
`puntos: 3`. Vale para `ejercicio`, `apartado` y `pregunta-multiple-md`,
en Typst y en HTML. Por defecto es `true`.

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

## ⚠️ Solución de Problemas

### Error: Logo no encontrado (file not found)

Comprueba dos cosas: (1) usa la clave `escudo`, no `logo` (nativa de
Quarto); (2) evita guiones bajos en la ruta (`mi_logo.png` llega a la
plantilla como `mi\_logo.png` y no se encuentra): renombra a `milogo.png`
o `us.jpg` y colócalo junto al documento.

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


## 📜 Historial de Cambios


- v 0.3.0 (10-10-2025) - Se ha añadido soporte para salida html (examtypst-html).
    
    Has creado un sistema de ejercicios y soluciones muy completo y profesional para usar con salida Html, con las siguientes características:

    ✨ **Características implementadas:**
      
    - Ejercicios numerados automáticamente con puntuación opcional
    - Soluciones inline (inmediatas) o al final del documento
    - Tres formatos de visualización:
      - Normal (expandido)
      - Colapsable (acordeón)
      - Pestañas con badges (con toggle para abrir/cerrar)
        - Placeholder informativo
        - Estilos CSS personalizados y elegantes
        - Animaciones suaves
    - Totalmente configurable desde el YAML

    Es un filtro muy potente y versátil para documentos educativos en Quarto. 

