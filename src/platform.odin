package main

import SDL "vendor:sdl2"

draw_rect :: proc(rects: ^[dynamic]DrawRect, rect: Rect, color: BVec4) {
	append(rects, DrawRect{FVec4{f32(rect.pos.x), f32(rect.pos.y), f32(rect.size.x), f32(rect.size.y)}, color, FVec2{0.0, 0.0}})
}

draw_line :: proc(rects: ^[dynamic]DrawRect, start, end: Vec2, width: f64, color: BVec4) {
	start, end := start, end
	if start.x > end.x {
		end, start = start, end
	}

	append(rects, DrawRect{FVec4{f32(start.x), f32(start.y), f32(end.x), f32(end.y)}, color, FVec2{f32(width), -1}})
}

draw_rect_outline :: proc(rects: ^[dynamic]DrawRect, rect: Rect, width: f64, color: BVec4) {
	x1 := rect.pos.x
	y1 := rect.pos.y
	x2 := rect.pos.x + rect.size.x
	y2 := rect.pos.y + rect.size.y

	draw_line(rects, Vec2{x1, y1}, Vec2{x2, y1}, width, color)
	draw_line(rects, Vec2{x1, y1}, Vec2{x1, y2}, width, color)
	draw_line(rects, Vec2{x2, y1}, Vec2{x2, y2}, width, color)
	draw_line(rects, Vec2{x1, y2}, Vec2{x2, y2}, width, color)
}

draw_rect_inline :: proc(rects: ^[dynamic]DrawRect, rect: Rect, width: f64, color: BVec4) {
	x1 := rect.pos.x + width
	y1 := rect.pos.y + width
	x2 := rect.pos.x + rect.size.x - width
	y2 := rect.pos.y + rect.size.y - width

	draw_line(rects, Vec2{x1, y1}, Vec2{x2, y1}, width, color)
	draw_line(rects, Vec2{x1, y1}, Vec2{x1, y2}, width, color)
	draw_line(rects, Vec2{x2, y1}, Vec2{x2, y2}, width, color)
	draw_line(rects, Vec2{x1, y2}, Vec2{x2, y2}, width, color)
}

set_cursor :: proc(type: string) {
	switch type {
	case "auto": SDL.SetCursor(default_cursor)
	case "pointer": SDL.SetCursor(pointer_cursor)
	}
	is_hovering = true
}
reset_cursor :: proc() { 
	set_cursor("auto") 
	is_hovering = false
}

get_text_height :: proc(scale: f64, font: string) -> f64 { return 0 }
measure_text :: proc(str: string, scale: f64, font: string) -> f64 { return 0 }
draw_text    :: proc(str: string, pos: Vec2, scale: f64, font: string, color: BVec4) { }

open_file_dialog :: proc() {}
get_system_color :: proc() -> bool { return false }
get_session_storage :: proc(key: string) { }
set_session_storage :: proc(key, val: string) { }
