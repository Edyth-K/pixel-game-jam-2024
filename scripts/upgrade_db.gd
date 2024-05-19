extends Node

const ICON_PATH = "res://assets/sprites/Upgrades/"
const UPGRADES = {
	"bubble1": {
		"icon": ICON_PATH + "bubble_icon.png",
		"name": "Bubble",
		"description": "Fires at the nearest enemy.",
		"level": "Level: 1",
		"prereq": [],
		"type": "weapon"
	},
	"bubble2": {
		"icon": ICON_PATH + "bubble_icon.png",
		"name": "Bubble",
		"description": "More Bubbles!",
		"level": "Level: 2",
		"prereq": ["bubble1"],
		"type": "weapon"
	},
	"bubble3": {
		"icon": ICON_PATH + "bubble_icon.png",
		"name": "Bubble",
		"description": "More Bubbles!",
		"level": "Level: 3",
		"prereq": ["bubble2"],
		"type": "weapon"
	},
	"bubble4": {
		"icon": ICON_PATH + "bubble_icon.png",
		"name": "Bubble",
		"description": "More Bubbles!",
		"level": "Level: 4",
		"prereq": ["bubble3"],
		"type": "weapon"
	},
	"urchin1": {
		"icon": ICON_PATH + "urchin_icon.png",
		"name": "Urchin",
		"description": "They've got a prickly personality.",
		"level": "Level: 1",
		"prereq": [],
		"type": "weapon"
	},
	"urchin2": {
		"icon": ICON_PATH + "urchin_icon.png",
		"name": "Urchin",
		"description": "More Urchins!",
		"level": "Level: 2",
		"prereq": ["urchin1"],
		"type": "weapon"
	},
	"urchin3": {
		"icon": ICON_PATH + "urchin_icon.png",
		"name": "Urchin",
		"description": "More Urchins!",
		"level": "Level: 3",
		"prereq": ["urchin2"],
		"type": "weapon"
	},
	"urchin4": {
		"icon": ICON_PATH + "urchin_icon.png",
		"name": "Urchin",
		"description": "More Urchins!",
		"level": "Level: 4",
		"prereq": ["urchin3"],
		"type": "weapon"
	},
	"seaweed1": {
		"icon": ICON_PATH + "seaweed_icon.png",
		"name": "Seaweed",
		"description": "Slice with the finesse of a sushi chef.",
		"level": "Level: 1",
		"prereq": [],
		"type": "weapon"
	},
	"seaweed2": {
		"icon": ICON_PATH + "seaweed_icon.png",
		"name": "Seaweed",
		"description": "More Seaweed!",
		"level": "Level: 2",
		"prereq": ["seaweed1"],
		"type": "weapon"
	},
	"seaweed3": {
		"icon": ICON_PATH + "seaweed_icon.png",
		"name": "Seaweed",
		"description": "More Seaweed!",
		"level": "Level: 3",
		"prereq": ["seaweed2"],
		"type": "weapon"
	},
	"seaweed4": {
		"icon": ICON_PATH + "seaweed_icon.png",
		"name": "Seaweed",
		"description": "More Seaweed!",
		"level": "Level: 4",
		"prereq": ["seaweed3"],
		"type": "weapon"
	},
	"lightning1": {
		"icon": ICON_PATH + "lightning_icon.png",
		"name": "Lightning",
		"description": "Nothing says back off like a personal thunderstorm.",
		"level": "Level: 1",
		"prereq": [],
		"type": "weapon"
	},
	"lightning2": {
		"icon": ICON_PATH + "lightning_icon.png",
		"name": "Lightning",
		"description": "Bigger Area!",
		"level": "Level: 2",
		"prereq": ["lightning1"],
		"type": "weapon"
	},
	"lightning3": {
		"icon": ICON_PATH + "lightning_icon.png",
		"name": "Lightning",
		"description": "Bigger Area!",
		"level": "Level: 3",
		"prereq": ["lightning2"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "turtleshell.png",
		"name": "Turtle Shell",
		"description": "The defense of a turtle, minus the slow.",
		"level": "Level: 1",
		"prereq": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "turtleshell.png",
		"name": "Turtle Shell",
		"description": "More Defense!",
		"level": "Level: 2",
		"prereq": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "turtleshell.png",
		"name": "Turtle Shell",
		"description": "More Defense!",
		"level": "Level: 3",
		"prereq": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "turtleshell.png",
		"name": "Turtle Shell",
		"description": "More Defense!",
		"level": "Level: 4",
		"prereq": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "flippers.png",
		"name": "Flippers",
		"description": "Zooom! Wait, how does a jellyfish wear these?",
		"level": "Level: 1",
		"prereq": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "flippers.png",
		"name": "Flippers",
		"description": "More Speed!",
		"level": "Level: 2",
		"prereq": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "flippers.png",
		"name": "Flippers",
		"description": "More Speed!",
		"level": "Level: 3",
		"prereq": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "flippers.png",
		"name": "Flippers",
		"description": "More Speed!",
		"level": "Level: 4",
		"prereq": ["speed3"],
		"type": "upgrade"
	},
	"tome1": {
		"icon": ICON_PATH + "anchor.png",
		"name": "Anchor",
		"description": "Size Matters",
		"level": "Level: 1",
		"prereq": [],
		"type": "upgrade"
	},
	"tome2": {
		"icon": ICON_PATH + "anchor.png",
		"name": "Anchor",
		"description": "Larger Attacks",
		"level": "Level: 2",
		"prereq": ["tome1"],
		"type": "upgrade"
	},
	"tome3": {
		"icon": ICON_PATH + "anchor.png",
		"name": "Anchor",
		"description": "Larger Attacks",
		"level": "Level: 3",
		"prereq": ["tome2"],
		"type": "upgrade"
	},
	"tome4": {
		"icon": ICON_PATH + "anchor.png",
		"name": "Anchor",
		"description": "Larger Attacks",
		"level": "Level: 4",
		"prereq": ["tome3"],
		"type": "upgrade"
	},
	"scroll1": {
		"icon": ICON_PATH + "hourglass.png",
		"name": "Hourglass",
		"description": "Decrease Attack Cooldown",
		"level": "Level: 1",
		"prereq": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": ICON_PATH + "hourglass.png",
		"name": "Hourglass",
		"description": "Decrease Attack Cooldown",
		"level": "Level: 2",
		"prereq": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": ICON_PATH + "hourglass.png",
		"name": "Hourglass",
		"description": "Decrease Attack Cooldown",
		"level": "Level: 3",
		"prereq": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": ICON_PATH + "hourglass.png",
		"name": "Hourglass",
		"description": "Decrease Attack Cooldown",
		"level": "Level: 4",
		"prereq": ["scroll3"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": ICON_PATH + "raincloud.png",
		"name": "Storm",
		"description": "When it rains, it pours.",
		"level": "Level: 1",
		"prereq": [],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ICON_PATH + "raincloud.png",
		"name": "Storm",
		"description": "More Projectiles!",
		"level": "Level: 2",
		"prereq": ["ring1"],
		"type": "upgrade"
	},
	"heal": {
		"icon": ICON_PATH + "health_icon.png",
		"name": "Heal",
		"description": "A small treat!",
		"level": "N/A",
		"prereq": [],
		"type": "item"
	}
}
