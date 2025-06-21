extends Control

var historias_terror = [
	"Una noche oscura, escuché un _ detrás de la puerta.",
	"El espejo comenzó a sangrar cuando dije _ tres veces frente a la _.",
	"El _ salió del armario, tomó el _ y se acercó lentamente a mi _.",
	"Desperté en un ataúd, con _ en la mano, rodeado por _, sin recordar mi _ ni cómo llegué a _.",
	"Cada medianoche, el _ aparece en el pasillo, gritando el nombre de _, arrastrando un _, con los ojos llenos de _ y una _ torcida.",
	"Cuando abrí el libro prohibido, invocamos sin querer a un _ que poseyó a _, cerró todas las _, rompió el _, gritó desde el _ y escribió nuestro destino con _."
]

var completed = []

@onready var lineEdit = $VBoxContainer/LineEdit
@onready var button = $VBoxContainer/Button
@onready var storyLabel = $story
@onready var acceptButton = $VBoxContainer/accept
@onready var newGame = $VBoxContainer/newgame

var story = ""

func _ready() -> void:
	acceptButton.visible = false
	button.pressed.connect(_set_text)
	acceptButton.pressed.connect(_set_story)
	newGame.pressed.connect(_restart)
	_set_story()

var story_to_return
func _set_story() -> void:
	storyLabel.text = "Leyendo una historia..."
	button.visible = true
	acceptButton.visible = false
	newGame.visible = false
	story_to_return = historias_terror.pick_random()
	for i in completed:
		if i == story_to_return:
			_set_story()
			break
		else: continue
	story = story_to_return

func _get_text() -> String:
	var texto = lineEdit.text
	return texto

func _set_text():
	var word = _get_text()
	var phrase = String(story)
	var newPhrase = ""
	var status = false
	for i in phrase:
		if i == "_":
			if status == true:
				newPhrase = newPhrase + i
			else:
				newPhrase = newPhrase + word
				status = true
		else:
			newPhrase = newPhrase + i
			continue
	story = newPhrase
	_verify()

func _verify():
	var status = false
	for i in String(story):
		if i == "_":
			status = true
			break
		else:
			continue
	
	if !status:
		_to_change_story()

func _to_change_story():
	if completed.size() >= 5:
		storyLabel.text = story + "\nHas Completado "
		newGame.visible = true
		button.visible = false
		acceptButton.visible = false
	else:
		completed.append(story_to_return)
		storyLabel.text = story
		acceptButton.visible = true
		button.visible = false

func _restart():
	completed = []
	_set_story()
