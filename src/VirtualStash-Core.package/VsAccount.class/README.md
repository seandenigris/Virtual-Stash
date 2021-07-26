# Chart of Accounts
An account can be created for two main reasons:
1. It distinguishes information that the user feels is valuable, and/or
2. It needs to be handled differently for tax reasons e.g. shows up on different lines of the return.
## Dimensions
A common place to run into trouble is when an account seems to properly exist in multiple places. For example, is "Public Transportation" "Transportation" or "Travel" or both (i.e. requiring two separate accounts)?  What if you live 30 minutes from a big city and take the train there? What if you're an hour away? Two? Does it matter why you went there (e.g. business or pleasure)? What if I own a plane and use it to commute?

The problem here is that things in life do not fit cleanly into one hierarchical tree. At best, one tree can capture a single dimension or aspect of the thing. Two of the most important dimensions in accounting (as in many other fields) are: *what* and *why*. For example, what did I spend this money on? I spent it on `Movie Tickets` And why did I spend it? I spent it for `Romance` because my `Wife` was dying to see that movie (although I wasn't really interested). Here we have an example of even a third dimension, which is a person connected to the *why*.

Perhaps a clearer example of when a person is a dimension is `Clothing`. We buy my clothing, my wife's clothing, and my daughter's clothing. Sure, I could create separate subaccounts for each, but consider all the other accounts that would have to be split up that way based on this logic - e.g. if we each had a car, a gym membership. Also, it wouldn't be so straightforward to analyze the expenditures of just one person because their expenses would be split up between all these accounts. The best you could do - if your software was flexible and powerful enough to support it, is match all the accounts named "Wife", but expression matching is error-prone at best. Imagine if your daughter was named Equity - not unthinkable in modern society - `Retained Earnings` and `Opening Balance` would show up as "hers".

The solution is to have multiple hierarchies representing the relevant dimensions, which allow items to be considered along multiple axes independently.
