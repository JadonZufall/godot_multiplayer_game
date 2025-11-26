class_name ConsoleStreamOut extends RichTextLabel

# Formatting rules requiring a parameter
const BB_COLOR: String = "[color=%s]%s[/color]"                                                     # [color, content]
const BB_BGCOLOR: String = "[bgcolor=%s]%s[/bgcolor]"                                               # [color, content]
const BB_FGCOLOR: String = "[fgcolor=%s]%s[/fgcolor]"                                               # [color, content]
const BB_SIZE: String = "[size=%d]%s[/size]"                                                        # [content]


# Text styling formatting rules
const BB_BOLD: String = "[b]%s[/b]"                                                                 # [content]
const BB_ITALICS: String = "[i]%s[/i]"                                                              # [content]
const BB_UNDERLINE: String = "[u]%s[/u]"                                                            # [content]
const BB_STRIKETHROUGH: String = "[s]%s[/s]"                                                        # [content]
const BB_PREFORMATTED: String = "[pre]%s[/pre]"                                                     # [content]

# Text alignment formatting rules
const BB_ALIGN_NONE: String = "%s"                                                                  # [content]
const BB_ALIGN_LEFT: String = "[left]%s[/left]"                                                     # [content]
const BB_ALIGN_CENTER: String = "[center]%s[/center]"                                               # [content]
const BB_ALIGN_RIGHT: String = "[right]%s[/right]"                                                  # [content]
const BB_ALIGN_FILL: String = "[fill]%s[/fill]"                                                     # [content]

enum BB_Alignment { NONE, LEFT, CENTER, RIGHT, FILL }
const BB_ALIGNMENT_FORMATTING: Dictionary[int, String] = {
	BB_Alignment.NONE: BB_ALIGN_NONE,
	BB_Alignment.LEFT: BB_ALIGN_LEFT,
	BB_Alignment.CENTER: BB_ALIGN_CENTER,
	BB_Alignment.RIGHT: BB_ALIGN_RIGHT,
	BB_Alignment.FILL: BB_ALIGN_FILL,
}

# URL formatting rules
const BB_URL: String = "[url]%s[/url]"                                                              # [url]
const BB_URL_NAME: String = "[url=%s]%s[/url]"                                                      # [url, content]

# Quote formatting rules
const BB_QUOTE: String = "[quote]%s[/quote]"                                                        # [content]
const BB_QUOTE_NAME: String = "[quote=%s]%s[/quote]"                                                # [quote_name, content]

# Spoiler formatting rules
const BB_SPOILER: String = "[spoiler]%s[/spoiler]"                                                  # [content]
const BB_SPOILER_NAME: String = "[spoiler=%s]%s[/spoiler]"                                          # [spoiler_name, content]

# Code formatting rules
const BB_CODE: String = "[code]%s[/code]"
const BB_CODE_LANGUAGE: String = "[code=%s]%s[/code]"                                               # [programming_language, content]

# List formatting rules
const BB_LIST_ITEM: String = "[li]%s[/li]"                                                          # [content]
# takes type parameter (optional)
const BB_ORDERED_LIST: String = "[ol]%s[/ol]"                                                       # [content]
# takes bullet parameter (optional)
const BB_UNORDERED_LIST: String = "[ul]%s[/ul]"                                                     # [content]

# Table formatting rules
# There are more table formatting rules including cells
# https://docs.godotengine.org/en/latest/tutorials/ui/bbcode_in_richtextlabel.html#reference
const BB_TABLE: String = "[table]%s[/table]"                                                        # [content]
const BB_TABLE_ROW: String = "[tr]%s[/tr]"                                                          # [content]
const BB_TABLE_HEADER: String = "[th]%s[/th]"                                                       # [content]
const BB_TABLE_CONTENT: String = "[td]%s[/td]"                                                      # [content]

# Media formatting rules
const BB_IMAGE: String = "[img]%s[/img]"                                                            # [content]
const BB_IMAGE_RESIZED: String = "[img=%dx%d]%s[/img]"                                              # [width, height, url]
const BB_YOUTUBE_VIDEO: String = "[youtube]%s[/youtube]"                                            # [video_id]

# Paragraph formatting rules
const BB_PARAGRAPH: String = "[p]%s[/p]"                                                            # [content]
const BB_PARAGRAPH_OPTS: String = "[p %s]%s[/p]"                                                    # [options, content]

# Single Character rules
const BB_CHAR: String = "[char=%s]"                                                                 # [hex_UTF-32_codepoint]
const BB_LINEBREAK: String = "[br]"                                                                 # No arguments
const BB_HORIZONTAL_RULE: String = "[hr]"                                                           # No arguments
const BB_HORIZONTAL_RULE_OPTS: String = "[hr %s]"                                                   # No arguments
const BB_INDENT: String = "[indent]"                                                                # No arguments
const BB_LB: String = "[lb]" # = [
const BB_RB: String = "[rb]" # = ]

const BB_HINT: String = "[hint=%s]%s[/hint]"                                                        # [tooltip, content]
const BB_FONT: String = "[font=%s]%s[/font]"                                                        # [font_path, content]
const BB_FONT_SIZE: String = "[font_size=%d]%s[/font]"                                              # [font_size, content]
const BB_LANG: String = "[lang=%s]%s[/lang]"                                                        # [language_code, content]

const BB_OUTLINE_SIZE: String = "[outline_size=%d]%s[/outline_size]"
const BB_OUTLINE_COLOR: String = "[outline_color=%d]%s[/outline_color]"

# [font_path, font_size, color, outline_size, outline_color, margin_left, margin_top, margin_right, margin_bottom, content]
const BB_DROP_CAP: String = "[dropcap font=%s font_size=%d color=%s outline_size=%d outline_color=%s margins=%d,%d,%d,%d]%s[/dropcap]"

#command-seperated list values must not be seperated by spaces
const BB_OPENTYPE_FEATURES: String = "[opentype_features=%s]%s[/opentype_features]"                 # [feature_list, content]

func bb_opentype_features_list_format(items: Array[String]) -> String:
	var result: String = ""
	for i in items:
		result = "%s,%s" % [result, i]
	return result

func bb_utf_32(code: String) -> String: return BB_CHAR % code
func bb_paragraph(content: String, opts: Array[String]=[]) -> String:
	#TODO
	push_error("Not implemented")
	return "#TODO"

func bbimage(url: String, image_size: Vector2=-Vector2.ONE) -> String:
	if image_size.x < 0 or image_size.y < 0:
		return BB_IMAGE % url
	return BB_IMAGE % [image_size.x, image_size.y, url]

func bbvideo(code: String) -> String:
	#TODO
	push_error("Not implemented")
	return "#TODO"

func bblist() -> void:
	push_error("Not implemented")
func bbparagraph() -> void:
	push_error("Not implemented")
func bbtable() -> void:
	push_error("Not implemented")

# This function is bad
func bbformat(
	data: String, color: String="", fg_color: String="", bg_color: String="", text_size: int=-1, lang="",
	font: String="", font_size: int=-1, hint: String="",
	outline_size: int=-1, outline_color: String="",
	bold: bool=false, italics: bool=false, underline: bool=false, strikethrough: bool=false, 
	quote: bool=false, quote_name: String="",
	spoiler: bool=false, spoiler_name: String="",
	code: bool=false, code_language: String="",
	preformatted: bool = false,
	alignment: BB_Alignment=BB_Alignment.NONE, 
	url: bool=false, url_destination: String="",
	) -> String:
	
	var result = "%s" % [data]
	
	if preformatted: 
		result = BB_PREFORMATTED % [result]
	
	if url and url_destination.length() != 0:
		result = BB_URL_NAME % [url_destination, result]
	elif url:
		result = BB_URL % [result]
	
	if code and code_language.length() != 0:
		result = BB_CODE_LANGUAGE % [result]
	elif code:
		result = BB_CODE % [result]
	
	if quote and quote_name.length() != 0: 
		result = BB_QUOTE_NAME % [quote_name, result]
	elif quote: 
		result = BB_QUOTE % [result]
	
	if spoiler and spoiler_name.length() != 0: 
		result = BB_SPOILER_NAME % [spoiler_name, result]
	elif spoiler: 
		result = BB_SPOILER % [result]
	
	if color.length() != 0: 
		result = BB_COLOR % [color, result]
	if fg_color.length() != 0: 
		result = BB_FGCOLOR % [fg_color, result]
	if bg_color.length() != 0: 
		result = BB_BGCOLOR % [bg_color, result]
	if outline_color.length() != 0:
		result = BB_OUTLINE_COLOR % [outline_color, result]
	if outline_size != -1:
		result = BB_OUTLINE_SIZE % [outline_size, result]
	
	if bold:
		result = BB_BOLD % [result]
	if italics:
		result = BB_ITALICS % [result]
	if underline: 
		result = BB_UNDERLINE % [result]
	if strikethrough: 
		result = BB_STRIKETHROUGH % [result]
	
	if text_size != -1: 
		result = BB_SIZE % [text_size, result]
	if font_size != -1:
		result = BB_FONT_SIZE % [font_size, result]
	if font.length() != 0:
		result = BB_FONT % [font, result]
	
	if hint.length() != 0:
		result = BB_HINT % [hint, result]
	
	result = BB_ALIGNMENT_FORMATTING[alignment] % [result]
	if lang.length() != 0:
		result = BB_LANG % [lang, result]
	
	return result

func write(data: String) -> void:
	append_text(data)

func write_line(line: String) -> void:
	append_text("%s\n" % line)

func bb_font_flags(message: String, bold: bool, italics: bool, underline: bool, strikethrough: bool) -> String:
	var result: String = message
	if bold:
		result = BB_BOLD % [result]
	if italics:
		result = BB_ITALICS % [result]
	if underline: 
		result = BB_UNDERLINE % [result]
	if strikethrough: 
		result = BB_STRIKETHROUGH % [result]
	return result

func bb_color(message: String, color: String) -> String:
	return BB_COLOR % [color, message]

func bb_bgcolor(message, color: String) -> String:
	return BB_BGCOLOR % [color, message]

const ERROR_COLOR: String = "red"

func format_input(message: String) -> String:
	return bb_bgcolor(message, "#9A9C99")

func format_output(message: String) -> String:
	return bb_bgcolor(message, "#5D5E60")

func format_error(error_type: String, message: String) -> String:
	return bb_color("%s %s" % [
		bb_font_flags("%s:" % error_type, true, false, false, false), message
	], ERROR_COLOR)
