textfield = textfield_words;

limit = 6;
offset = 0;

prefixes = {
	count:		0,
	time:		0,
	entries:	undefined
}

anagrams = {
	count:		0,
	time:		0,
	entries:	undefined
}

// Load the wordslist from json
var _buffer = buffer_load("words.json");
words = json_parse(buffer_read(_buffer, buffer_text));
buffer_delete(_buffer);

// Create and load a precomputed binder in alpabetical order
words_alpha = new Binder(words, binder_pass_through);
words_alpha.load("words_alpha.json");

// Create and load a precomputed binder in alpabetical order
words_anagrams = new Binder(words, binder_string_sort);
words_anagrams.load("words_anagram.json");