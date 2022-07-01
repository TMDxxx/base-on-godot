extends Node2D

var direction = Vector2(10,20)
var num = 0
func change_num(num):
	self.num = num 
	print(num)

func return_num():
	return num
