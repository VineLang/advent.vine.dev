#import "/lib.typ": *
#import hyptyp: t

#import "img.typ"

#hyptyp.resource("/theme.css", read("theme.css"))

#img.resources

#show: hyptyp.show-site(
  root: "content/welcome.typ",

  root-slug: "/",

  path-to-slug: site => path => (hyptyp.defaults.path-to-slug)(site)(
    path.trim("/content", at: alignment.start)
  ),

  sidebar-header: site => _ => [
    #t.a(class: "logo", href: "/")[#t.img(class: "logo", src: "/logo.svg")]
  ],

  head-extra: site => _ => {
    t.link(rel: "stylesheet", href: "/theme.css")
    img.icons
  }
)
