extends Control

var historias = [
	"Cuando la nación del _palabra_ se levante, las llanuras del este caeran",
	"Tomando _palabra_, ahora va al oeste"
]

@onready var lineEdit = $VBoxContainer/LineEdit
@onready var button = $VBoxContainer/Button

func _ready() -> void:
	button.pressed.connect(_get_text)

func _get_text():
	var texto = lineEdit.text
	print("Texto: ", texto)
