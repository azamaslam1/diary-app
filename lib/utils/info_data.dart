import '../Screens/Authentication/main_auth.dart';
import '../main.dart';

const infoGoalText =
    "God laughs the most when a person plans.”  Does it ever happen to you that your day is full of tasks that you are not able to handle even in a week?  Stop and define 3 main goals for the week.  Don't push the saw, and define the really essential things that must be done that week";
const infoPleasureText =
    "Plan 3 joys that you will indulge in during this week.";
const infoFinanceText =
    "Finance. Mark your income and expenses every day.  Achieving financial success is the result of correct daily habits. ";
const infoHabitText =
    "Habit of the week. It is a simple, time-saving activity that you will do every day (several times a week) and will move you closer to your goal.  Write down the current week's habit for that week.  Don't start several new habits at once.  If you add another habit in the next week, continue with the habit from the previous weeks until they become your firm habit as a stable part of your lifestyle.  Subsequently, during the weekly evaluation, note down your experience here, which will give you an overview of all your habits.";
const infoSuccesseText =
    "Successes. Allow yourself a child's joy and appreciate yourself every day.  It is important.  If you can't find a reason to celebrate, why bother trying next time?If the day was not as expected, find at least 3 achievements and mark them in your calendar. The constant pursuit of recognition and praise can cause us to start giving ourselves to others at the expense of ourselves Way - it is the absence of awareness of our own worth. Gradually, you will stop depending on the praise and recognition of others and you will begin to realize your worthStop doing things to please others, but start creating your life with activities that will write you.Too much clinging to the result causes stress, tension and the release of the hormone cortisol.  It prevents anything we do from bringing us joy.  Rather, focus your full attention on the activity you are doing.  Do it with joy and in flow.  The hormone dopamine (hormone of success) will be released into your brain, and this will make you happier with what you are doing and you will achieve your results much easier and faster.";
const infoLearningText =
    "What my day was like The right questions are key.  Always pay attention to them at the end of the day.  Questions bring answers.  Dont ask why this happened to me.  Ask: How did I do it?  How could I have done it differently/better.";
const infoMorningRitualText =
    "Morning rituals.  The goal is to wake up and start the day.  Give yourself motivation and a positive attitude.";
const infoEveRitualText =
    "Evening rituals.  The goal is to evaluate, realize, celebrate and appreciate the results.  Preparation for sleep and relaxation.";
const infoProgramText =
    "Schedule of the day.  In nature, everything has its time and thanks to that we feel safe and secure in it.  The sun always rises in the east and we pick an apple in autumn.  We also need order.  Determine when and what we will do during the day/month or year.  If we don't have order, we feel overwhelmed by stress and pressure and that we haven't accomplished anything.  Create your ideal workday schedule here.";
const infoRitualsText =
    "Tips on rituals (repetitive activities), longevity that give us confidence, are supports for us and help us not to lose focus in a world full of changes.  Create a list of rituals here.";
const infoGratitudeText =
    "Gratitude is a way of realizing what we have. Every thing, person or feeling will settle down. We begin to take it for granted and stop paying attention to it. Then we wonder why we are losing it. Every morning think about at least three things you are grateful for and write them down. You will have more appetite and motivation for what can be a challenging day. As soon as you write 3 gratitudes, spend at least 5 minutes looking at your goal board and reading your victory here..";
const infoPriorityText =
    "Priority of the day.  Literally laser-focus on what is most important to you at the moment and avoid scattering your attention.  What priority of the day will get you closer to accomplishing your 3 goals for the week the fastest?  What do you need to do to have a great feeling about the day?  It won't always be about work, but you will get more done than before.  Define 1 main priority of the day that will move you closer to your goals or change the quality of your life.";
var quoteData = (language == "English")
    ? english[
        'The biggest expert on myself is myself! Only I know who I am, what I know, what I need and where I m going']
    : (language == "Slovak")
        ? slovak[
            'The biggest expert on myself is myself! Only I know who I am, what I know, what I need and where I m going']
        : czech[
            'The biggest expert on myself is myself! Only I know who I am, what I know, what I need and where I m going'];
var infoQuoteBelow = (language == "English")
    ? english[
        'How do you know you are growing? If you dont know who you are and where you want to go, you wont find out.']
    : (language == "Slovak")
        ? slovak[
            'How do you know you are growing? If you dont know who you are and where you want to go, you wont find out.']
        : czech[
            'How do you know you are growing? If you dont know who you are and where you want to go, you wont find out.'];
var infoBelow3 = (language == "English")
    ? english[
        'The key element is knowing how to define the goal itself (create it in your mind) and begin to focus on it. The basis is to realize and write down the answers to the following questions:']
    : (language == "Slovak")
        ? slovak[
            'The key element is knowing how to define the goal itself (create it in your mind) and begin to focus on it. The basis is to realize and write down the answers to the following questions:']
        : czech[
            'The key element is knowing how to define the goal itself (create it in your mind) and begin to focus on it. The basis is to realize and write down the answers to the following questions:'];
var dataSchedule =
    "Time is our greatest wealth. Only when we recognize its true value will we stop losing it We all have the same amount of time.  Exactly 86,400 seconds a day.  How we use it is up to us.  Those who complain the most about the lack of time waste it the most. They don't realize how much time they waste on irrelevant tasks, clutter, fragmentation, or multitasking (working on many tasks at once). Lack of time = you are not clear about your priorities. Stop saying you dont have time.  Its not true, you have enough time. Say its not your priority. Realize that without a systematic plan and measurement of your growth, most of what you do, say, and spend your time during the day - is not important.  If the given activity is not related to your dreams, does not bring you benefit or joy, cross it out of your diary.  Embrace the time you have as your greatest asset. Consciously choose who you spend your time with and what you invest it in.  Realize whether the activity charges you, moves you forward or you are exhausted after it and you have to force yourself into it. HOW YOU LIVE YOUR DAYS IS HOW YOU LIVE YOUR LIFE!  Stop putting off what is important to you. Those who know how to manage their time manage their life.  He who knows how to fill his time, fills his life.  He who has time is able to make all his dreams come true. Managing your time is important. Richard Branson";
var infoRituals =
    "SPIRIT (personality, inner intimacy), SOUL (mind-IQ, feelings - EQ, self-will), BODY (physical) Do a specific activity - a ritual - for each area every single day.  Get inspired by the tutorial below.  Appropriate breathing is a tool with which you supply the necessary energy to the given area.";
var eveRituals =
    "MORNING RITUALS - the goal is to wake up, start the day.  Give yourself motivation and a positive attitude. SPIRIT (awaken the inside) - Meditation, prayer, entering into oneself, searching for the truth about oneself and one's direction, thinking about one's mission in life, disappearing into nature, walking in nature.  -Gratitude - write down for the day. SOUL (set brain/self) -Vision board - browse.-My victories-read aloud.  - Visions, dreams, goals - read.  -Reading books, listening to motivational recordings. -Imagine the upcoming day and how you want to feel. -What I feel when I wake up, how I want to feel and what I want to radiate to the environment. - Schedule dña - remind yourself of it here - Write down the priority of the day for the given day.  - Program of the day - write it down for the given day.BODY (awaken the body) - Stretch while still in bed, tense your muscles and relax, suitable exercise, dynamic breathing, running, walking, optimal nutrition and drinking regime.";
var infoGoalBoards =
    "Upload here pictures of your goals that you want to achieve in 2023 in the following areas: Personal development Time for yourself Work and career Money and passive income Donation Family and relationships Health and fitness";
var infoVictory =
    "MY VICTORY I thank you for my life, for everything pleasant and unpleasant, because I know that I am a better person and I am moving closer to my mission in life. I am able to release from the depths of myself any pain and hurt from the present and the past and replace them with love and gratitude I forgive myself, I forgive everyone, I am satisfied, I shine, I am full of joy.  Thank you for being me. I love myself. Life is movement - movement is change.  Thank you for the changes and challenges that come into my life. I am ready to accept and handle them. Life is joy and I rejoice. I create a healthier and happier body full of vitality and energy with every single breath (Breath) I love and live my body every day with the right food and thoughts. I think in love, I live in love, I act in love, I speak in love, I get everything I need at the right time and place. Everything I do, I do 100%. I am a winner.  Everything is possible.  I can do it, I'll give it! I am a huge source of energy and strength. My money works for me every day, multiplying and generating more and more money for me. I have enough money to live the lifestyle I want. I am financially free.  I get rich by doing what I love. Money comes to me easily every day, from all sides and in large quantities. Coincidences do not exist.  I attract what I radiate.  What do I want to attract? I am getting better and better day by day in all areas. I receive love, I receive success, I receive health, I receive happiness, I receive peace, I receive money, I receive visions, I receive joy, I receive courage, I receive enthusiasm. I have everything what I need. And THAT'S IT.";
var infoVision =
    "MY MISSION A mission is a concrete idea of what kind of person you want to become one day, who you want to be.  Your mission describes how you want to contribute to a certain change with your life and thus create a better life on earth.  It is the meaning of life.  A solid point that will always show you whether what you are doing right now is part of your mission or someone else's mission.  The time dedicated to fulfilling our own mission is what makes us happy.  What is your mission?";
var infoFutureVision =
    "MY VISION OF THE FUTURE Define your own values using the question: What is important to me?. Then create your personal vision. A personal vision is an idea of what your ideal life should look like in 5, 10, 20 years. A vision for yourself,  you create your family, career or business by imagining that you are not limited by anything. Imagine if you waved a magic wand and created your ideal future. What would it look like?";
var infoDreams =
    "IM LIST OF DREAMS What do you dream about, what do you desire?  Imagine that you have all the money in the world, experience, information, contacts at your disposal.  You can be, have or do anything you want.  Write down everything you would like if your potential had absolutely no limits.";
var infoListGoals =
    "LIST OF GOALS A dream remains a dream unless you turn it into a goal.  Make it concrete and give it a time limit.  Set your goals so that they are in line with your vision and mission. Write down 10 goals for the next 12 months.  Write down your goals in the first person, in a positive way and in the present tense (eg: my monthly income is 3,000 euros, my weight is 60 kg, I have a new silver car Audi A4, 3.0 diesel, and similar… ";
