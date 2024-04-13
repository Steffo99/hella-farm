class_name Log

## Logging utilities


## Print to standard output.
##
## Pass self to the first parameter.
static func p(obj: Node, message: String) -> void:
	print("[%s] %s" % [obj, message])
