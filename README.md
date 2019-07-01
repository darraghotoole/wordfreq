# Wordfreq

Wordfreq fetches a Wikipdia page and reports *n* most frequent words on that page.

## Usage 

With Bundler 2.0.2 installed,


```
bundle install
bundle exec bin/wordfreq [page_id] [n]
```

E.g.:

```
$ bundle exec bin/wordfreq 21721040 5                                                                                                                                                                
URL:                                                                                                                                                                                                 
https://en.wikipedia.org/w/api.php?action=query&prop=extracts&pageids=21721040&explaintext&format=json                                                                                               
                                                                                                                                                                                                     
Title: Stack Overflow                                                                                                                                                                                
                                                                                                                                                                                                     
Top 5 words:                                                                                                                                                                                         
                                                                                                                                                                                                     
- 20 questions                                                                                                                                                                                       
                                                                                                                                                                                                     
- 18 stack                                                                                                                                                                                           
                                                                                                                                                                                                     
- 15 overflow                                                                                                                                                                                        
                                                                                                                                                                                                     
- 12 users                                                                                                                                                                                           
                                                                                                                                                                                                     
- 11 question, that
```


## Assumptions
- We do not try and pull the full article text if the extract we get from the API is truncated.  Wikipedia generally discourages large-scale crawling, and recommend that you just download the database itself instead of hitting their webservers.  See: https://en.wikipedia.org/wiki/Wikipedia:Database_download
- All non-alphanumeric are stripped
- All words shorter than 4 characters are dropped
