# theScore "the Rush" Interview Challenge
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home challenge?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (like Elixir/Phoenix, Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Challenge Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo is a sample data file [`rushing.json`](/rushing.json).

##### Challenge Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of [`rushing.json`](/rushing.json)
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted data as a CSV, as well as a filtered subset

2. The system should be able to potentially support larger sets of data on the order of 10k records.

3. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

### Installation and running this solution

#### Requirements

- `make`: Used to run make targets that starts the app
- `docker`: The application si built and run by docker. This helps running the application on different system or Elixir installed version.

#### Start the application

```sh
make foreground # Starts the application in foreground
make background # Starts the application in background
```

If you started the app in background, you can start an iex shell in it by running `make remote-console`. Once you want to stop the background process, simply run `make kill`.

#### Open the application

Open your favorite browser at `http://localhost:4000` and you should see the table of records


#### Decisions and explanation

##### Pagination

You might notice that the table is paginated. Even though the challenge specs does not have any requirement about paginating the data, it does states the following:

> 2. The system should be able to potentially support larger sets of data on the order of 10k records.

Therefore, displaying 10k+ records in a single web page is pretty heavy for a browser.

But, the specs also states the following

> 4. The user should be able to download the sorted data as a CSV, as well as a filtered subset

So you can select "All records" in the per page select to have the whole list of players.

##### Loading the json in an Agent

Eventually, if we were to have relations with this set of data, maybe a database would do a better job.

The Agent is started with the server and loads the data in memory under the supervision tree of the application. Which means that the whole data is available, straight from the ram and from another Erlang process.

If the process running the Agent crashes, it'll be automatically restarted by the supervisor. You can easily test it by killing the PID manually or through the Observer.

##### React as a frontend for a such simple task

Since I know it, React has always been my goto library for writing user interfaces. It's powerful, well written, has a lots of powerful features such Context API and Hooks and it makes UI fun to write.

I almost went for a Phoenix LiveView UI but I prefered to use a tech that I'm more used to.

##### OTP release

Inside the docker image is a OTP release of the application. It is built through a multi stage dockerfile so the final built image weighs ~40MB.
