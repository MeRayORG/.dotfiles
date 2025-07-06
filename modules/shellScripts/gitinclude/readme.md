# The What

A git include script that looks for a git include file in your git directory and if it finds one it adds all the files included in it to git and nothing else.

Now the why,

# Fuck Git: A Journey Through Its Half-Baked Hellscape of Ignore Rules and Sparse Checkouts

So here's what happened.

I wanted to add a few very specific files to Git. You know, just some config files buried in subdirectories — nothing fancy. Naturally, I thought, *"Hey, let’s use `.gitignore`. That’s what it’s for, right?"* You start with the idea: **include the full directory, then exclude everything you don’t want.** Sounds reasonable.

And at first, that kind of works.

But then Git pulls its first little magic trick: it won’t even *look into* subdirectories that are themselves ignored. Because unless you explicitly tell Git to check every single subpath, it just says: *“Well, this folder's ignored, so everything inside it must be too.”* Which is fucking wild. Why even allow negated rules (`!`) if they won’t work unless you manually include every single folder leading up to the file?

Fine. Whatever. I go and add those intermediate directories. Ugly, but doable.

And then comes the next slap: turns out, some of the stuff I’m trying to track includes `.git/` folders — maybe submodules, maybe just embedded repositories. And even though these are very explicitly ignored in my `.gitignore`, Git decides, *"Nope! Gotta track those! Definitely gonna track those for you."* Like it’s doing me a favor. Like it knows better.

So now `.gitignore` is acting like a gaslighting ex. You tell it what you want, it nods, and then does the exact opposite while insisting it’s for your own good.

Fine. *Fuck it.* Let’s try **sparse-checkout**.

Sparse-checkout seems promising at first. There are two modes: **cone** and **non-cone**. Cone mode looks great! It's made for humans! It lets you just say, *“Hey Git, I want these directories,”* and Git nods along like a well-trained assistant.

But then you discover the fine print: *Cone mode doesn’t support individual files.*

**Why?**  
No idea. Apparently, in cone mode, files are illegal. You can only ask for directories. So if you want to track just one file inside `.config/some-app/some-folder/`, Git says, *“Oh, sorry, that’s not a cone-shaped request. I only eat folders now.”*

Okay, so now you switch to **non-cone mode**, because you're not a folder supremacist.

You try to include just the files you want — simple lines like:

```
.config/some-app/some-folder/settings.json
```

But Git doesn’t care. Because unless you **also** include every single parent directory explicitly — and I mean **every. single. one.** — Git acts like the file was never part of the repo in the first place. It won’t even try to find it unless you lay breadcrumbs all the way from root to leaf.

And if you're in cone mode and you *do* include a folder, for example `.config`? Then Git helpfully decides to give you the **entire fucking `.config` directory**.  s
Not just the folder you specified. Not just the thing you need.

---

## The Final Middle Finger

Eventually, I broke. I gave up. I said, *“Fine. I’ll do it your way.”* I switched to cone mode. I added the exact directory the file lives in. Nothing more, nothing less. That’s what cone mode is designed for, right? Just directories. Clean, structured, minimal.

And what did Git do?

**It gave me the entire fucking `.config` directory.**

That’s right. I asked for one nested directory — and Git went, *“Cool, here’s everything under `.config/`. Hope you like bonus clutter.”* Dev junk, unrelated settings, `.trash/`, some app you haven’t touched in two years — all of it came flooding in.

And the worst part? There was no misconfiguration. No typo. No misunderstanding.  
Git did exactly what it was programmed to do.

It just did something no one sane would ever actually want.

It’s like walking into a library and asking for one book from a shelf — and they wheel out the entire shelf, dump it on your desk, and walk away like they did you a favor.

---

## Git: powerful, flexible, and completely allergic to doing the obvious thing.

**Fuck Git.**

---

*Full disclosure:* the article above was written by AI, but it actually was directly from a rant I gave it about this problem, and I shaped it and instructed it on most lines on what to do, because I can't write for shit, and nobody would want to read my rant otherwise.

**Rant over.**
