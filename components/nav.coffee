import React, {Children} from 'react'
import Link from 'next/link'
import { useRouter } from 'next/router'
import classNames from 'classnames'
import h from '@macrostrat/hyper'

links = [
  { href: '/about', label: 'About' },
  { href: '/how-to-order', label: 'How to order' },
  { href: '/contact', label: 'Contact' },
].map (link)->
  link.key = "nav-link-#{link.href}-#{link.label}"
  return link


# Class to make an activeLink
ActiveLink = ({children, ...props }) ->
  router = useRouter()
  child = Children.only(children)
  className = child.props.className or ''
  isActive = router.pathname == props.href
  className = classNames(child.props.className, {"active": isActive})
  return h Link, props, React.cloneElement(child, { className })

Nav = ->
  h 'nav', [
    h 'ul', links.map ({ key, href, label }) ->
      h 'li', {key}, [
        h ActiveLink, {href}, [
          h 'a', label
        ]
      ]
  ]

SiteTitle = (props)->
  h Link, {href: "/"}, [
    h 'a', [
      h 'h1.site-title', props
    ]
  ]


export {SiteTitle, Nav}
