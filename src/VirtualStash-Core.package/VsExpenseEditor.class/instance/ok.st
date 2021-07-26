callbacks
ok

	date dateModel accept.
	account accept.
	description accept.
	amount accept.
	"model := VsExpense paid: amount text asNumber on: date date for: description text inCategory: account text."
	VsPre2013Books uniqueInstance on: date date iPaid: amount text asNumber for: description text categorizeAs: account text.