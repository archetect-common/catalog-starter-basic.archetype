let context = #{};

context.archetect_version = archetect::version();

// This generally comes from ANSWERS, but prompting for it ensures it is in the context 
context += prompt("Project Author:", "author_full", #{
    placeholder: "Your Name <your.name@example.com>",
});

context += prompt("Catalog Description:", "description", #{
    placeholder: "Python AI/ML"
});

let description = context.description;
remove(description, " catalog");
remove(description, " Catalog");
context.description = description;

context += prompt("Author:", "author_full", #{
    placeholder: "Your Name <your.name@domain.com>",
    help: "Author Name and Email",
});

context += prompt("Catalog Name:", "project-name", #{
    defaults_with: kebab_case(context["description"]),
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
        FixedKeyCasedValue("project-title", TitleCase),
    ],
});

context += prompt("Source Control:", "source-control", #{
  defaults_with: "Github",
  type: Select([
    "Github",
    "None",
  ]),  
});

if context.contains("source-control") {
    if context["source-control"] == "Github" {
        context += prompt("Github Organization:", "organization-name", #{
          placeholder: "orgname/username",
        });
        context += set("git-repo", render("git@github.com:{{ organization-name }}/{{ project-name }}.catalog.git#1", context));
        render(Directory("contents/github"), context);
      
        display();
        display(render("cd {{ project-name }}.catalog", context));
        display("git init -b main");
        display(render("gh repo create {{ organization-name }}/{{ project-name }}.catalog --public --source=. --remote=origin", context));
        display("git add .");
        display("git commit -m 'initial commit'");
        display("git push -u origin HEAD");
    }
}

render(Archetype("gitignore"), Path(`${context["project-name"]}.catalog`), #{
    ignore: ["IDEA", "VSCode", "Eclipse"]
});

render(Directory("contents/base"), context);



