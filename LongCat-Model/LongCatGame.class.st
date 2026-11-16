Class {
	#name : 'LongCatGame',
	#superclass : 'Object',
	#instVars : [
		'cat',
		'boardSize',
		'food',
		'status'
	],
	#category : 'LongCat-Model',
	#package : 'LongCat-Model'
}

{ #category : 'Run' }
LongCatGame class >> run [
    | juego |
    juego := LongCatGame new.
    Transcript show: 'Cabeza inicial: ', juego cat head printString; cr.
    Transcript show: 'Comida en: ', juego food printString; cr.
    juego moveRight.
    Transcript show: 'Nueva cabeza tras mover derecha: ', juego cat head printString; cr
]

{ #category : 'accessing' }
LongCatGame >> cat [
	^ cat
]

{ #category : 'initialization' }
LongCatGame >> initialize [
	super initialize.
	boardSize := 10@10.
	cat := LongCat new.
	food := 5@5.
	status := #playing.
	
]

{ #category : 'testing' }
LongCatGame >> isLost [
	^ status = #lost
]

{ #category : 'actions' }
LongCatGame >> moveDown [
	self stepTowards: 0 @ 1
]

{ #category : 'as yet unclassified' }
LongCatGame >> moveLeft [
	self stepTowards: -1 @ 0
]

{ #category : 'as yet unclassified' }
LongCatGame >> moveRight [
	self stepTowards: 1 @ 0
]

{ #category : 'actions' }
LongCatGame >> moveUp [
	self stepTowards: 0 @ -1
]

{ #category : 'as yet unclassified' }
LongCatGame >> respawnFood [
	"Posiciona la comida en un lugar aleatorio simple"
	food := ((1 to: boardSize x) atRandom) @ ((1 to: boardSize y) atRandom)
]

{ #category : 'as yet unclassified' }
LongCatGame >> stepTowards: aDelta [
	| newHead |
	status = #playing ifFalse: [ ^ self ].
	
	newHead := cat head + aDelta.
	
	"1. Validar colisión con las paredes (Límites del tablero)"
	(newHead x between: 1 and: boardSize x) and: [ 
		newHead y between: 1 and: boardSize y ] 
		ifFalse: [ 
			status := #lost.
			^ self ].
			
	"2. Validar colisión contra su propio cuerpo"
	(cat occupies: newHead) ifTrue: [ 
		status := #lost.
		^ self ].
		
	"3. Verificar si come la comida"
	newHead = food ifTrue: [ 
		cat growTowards: newHead.
		self respawnFood.
	] ifFalse: [ 
		cat moveTowards: newHead.
	]
]
