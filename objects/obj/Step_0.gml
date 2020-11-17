// Hacky gameplay
interactive_search = function(_cur_node, _cur_pos, _to_pos, _half)
{
	if (escape) { return; }

	if (_cur_node.branch == pointer_null)
	{
		show_debug_message("Found note " + string(_cur_node.beat_length) + " at pos " + string(_to_pos) + " from pos " + string(_cur_pos) + " in stanza " + string(play_stanza));
		escape = true;
		return;
	}

	if (_to_pos >= _cur_pos + _half)
	{
		if (_cur_node.branch[1] != pointer_null) // Terminate at rests.
		{
			interactive_search(_cur_node.branch[1], _cur_pos + _half, _to_pos, ceil(_half / 2));
		}
	} else {
		if (_cur_node.branch[0] != pointer_null) // Terminate at rests.
		{
			interactive_search(_cur_node.branch[0], _cur_pos, _to_pos, ceil(_half / 2));
		}
	}
}

play_stanza = mouse_x div staff_width;
play_note = (mouse_x - (play_stanza * staff_width)) div smallest_note_width
//show_debug_message (string(play_stanza) + ", " + string(play_note));

if (mouse_check_button_pressed(mb_left))
{
	if (play_stanza < array_length(staff))
	{
		escape = false;
		interactive_search(staff[play_stanza], 0, play_note, stanza_length >> 1);
	}
}