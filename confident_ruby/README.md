# Ruby is designed to make programmers happy.
– Yukhiro "Matz" Matsumoto

The next insights about writing clean and understable code in ruby is insipred by the book:
Confindent Ruby by Avdi Grimm.

> A single method is like a page in that story. And unfortunately, a lot of methods are just as convoluted, equivocal, and confusing as that made-up page above.


I believe that if we take a look at any given line of code in a method, we can nearly always categorize it as serving one of the following roles:

1. Collecting input
2. Performing work
3. Delivering output
4. Handling failures

For intsance, lets take a look at the next example which actually looks everwhelming, its not ordered.....🤔
![Screenshot 2023-05-05 at 18 02 24](https://user-images.githubusercontent.com/72522628/236586862-eb9a587f-8b8b-4608-94de-1b99442b3fa2.jpg)
