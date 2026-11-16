Class {
	#name : 'LongCat',
	#superclass : 'Object',
	#instVars : [
		'segments',
		'direction'
	],
	#category : 'LongCat-Model',
	#package : 'LongCat-Model'
}

{ #category : 'accessing' }
LongCat >> body [
	^ segments allButFirst
]

{ #category : 'as yet unclassified' }
LongCat >> growTowards: aNewHeadPosition [
	"Avanza agregando la nueva cabeza pero SIN remover la cola (el gato se alarga)"
	segments addFirst: aNewHeadPosition
]

{ #category : 'accessing' }
LongCat >> head [
	^ segments first
]

{ #category : 'initialization' }
LongCat >> initialize [
	super initialize.
	"Comienza con 3 segmentos horizontales por defecto"
	segments := OrderedCollection with: 3@5 with: 2@5 with: 1@5.
	direction := 1@0. "Se mueve hacia la derecha por defecto"
]

{ #category : 'as yet unclassified' }
LongCat >> moveTowards: aNewHeadPosition [
	"Avanza agregando la nueva cabeza y removiendo la cola (no crece)"
	segments addFirst: aNewHeadPosition.
	segments removeLast
]

{ #category : 'as yet unclassified' }
LongCat >> occupies: aPoint [
	^ segments includes: aPoint
]
