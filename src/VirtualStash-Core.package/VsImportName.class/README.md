"Name" seems to be the most generic, widely applicable term for this field, which is alternately called `Name`, `Description`, or `Payee`. `name` is a bit confusing because it doesn't always necessarily represent a *name* per se. For example, it might be "CHECK 101" for a check transaction. However, we chose it in favor of `description` favoring simplicity and because we are using Magritte and would have otherwise ended up with gobbledygook like `importedDescriptionDescription`.
# Implementation Notes
Previously, payment processor and counterparty name were calculated on object creation. While efficient, the downside was that it was hard to develop and debug because if the internals changed, all instances needed to be refreshed. So we now calculate those fields on each access until we have a reason to optimize.
# Exchange formats
From the [OFX 2.2 Spec](https://www.ofx.net/downloads/OFX%202.2.pdf), page 216:
Note: Provide NAME or PAYEE, not both
- <NAME> Name of payee or description of transaction, A-32
- or-
<PAYEE> </PAYEE> Payee aggregate, see section 12.5.2.1
<EXTDNAME> Extended name of payee or description of transaction, A-100
#Printing
Historical note: My display string used to print my suggestion if available, but it wasn't generally useful and caused confusion. For example, for a patch browser where I was the original value, I would print something unexpected - possibly the new value!

# Software Implementations
- GnuCash has a freeform field which can accept any input
- QuickBooks enforces a to-one link to a vendor
