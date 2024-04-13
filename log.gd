class_name Log

## Logging utilities


## Print to standard output in cyan.
##
## Pass self to the first parameter.
static func p(obj: Node, message: String) -> void:
	print_rich("[color=cyan]{%s} %s[/color]" % [obj, message])


## Print to standard output in yellow.
##
## Pass self to the first parameter.
static func w(obj: Node, message: String) -> void:
	print_rich("[color=yellow]{%s} %s[/color]" % [obj, message])


## Print to standard output in red.
##
## Pass self to the first parameter.
static func e(obj: Node, message: String) -> void:
	print_rich("[color=red]{%s} %s[/color]" % [obj, message])
