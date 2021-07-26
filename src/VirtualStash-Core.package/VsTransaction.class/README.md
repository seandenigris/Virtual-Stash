I represent a financial transaction, like a credit card purchase. I have at least two {{gtClass:VsSplit|label=splits}}, possibly more.
# Numbering
I can have a unique ID and philosophically my {{gtClass:VsSplit|label=splits}} can have their own individual IDs.
# Optional Fields
GnuCash's sqlite DB stores these in a separate *slots* table, presumably to save space. At this point, it seems like premature optimization, so we do TSTTCPW, which is to treat them as just another field.
- Memo: commonly used for relatively few transactions
# Importing from GnuCash
We start with CSV format, since we already have  a parser for that. The tricky bit is that each row consists of transaction fields followed by split fields. The first row is completely filled out and represents the transaction along with its first split. This is followed by one or more rows with just the split filled out, which are additional splits for that previous transaction.
