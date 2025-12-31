/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]        = "JetBrainsMono Nerd Font:size=12";
static const char* normbgcolor  = "#00141d";  /* Inactive tab - matches dwm background */
static const char* normfgcolor  = "#FFFFFF";  /* Inactive tab text - matches dwm fg */
static const char* selbgcolor   = "#b3e5fc";  /* Active tab - matches dwm selected */
static const char* selfgcolor   = "#1a1a1a";  /* Active tab text - matches dwm selected fg */
static const char* urgbgcolor   = "#4fc3f7";  /* Urgent tab - matches dwm border color */
static const char* urgfgcolor   = "#00141d";  /* Urgent tab text - dark background */
static const char before[]      = "";         /* Clean separator - no visual clutter */
static const char after[]       = "│";        /* Subtle divider between tabs */
static const char titletrim[]   = "…";        /* Ellipsis for truncated titles */
static const int  tabwidth      = 200;
static const Bool foreground    = True;
static       Bool urgentswitch  = False;

/*
 * Where to place a new tab when it is opened. When npisrelative is True,
 * then the current position is changed + newposition. If npisrelative
 * is False, then newposition is an absolute position.
 */
static int  newposition   = -1;               /* New tabs at end (more intuitive) */
static Bool npisrelative  = False;

#define SETPROP(p) { \
        .v = (char *[]){ "/bin/sh", "-c", \
                "prop=\"`xwininfo -children -id $1 | grep '^     0x' |" \
                "sed -e's@^ *\\(0x[0-9a-f]*\\) \"\\([^\"]*\\)\".*@\\1 \\2@' |" \
                "xargs -0 printf %b | dmenu -l 10 -w $1`\" &&" \
                "xprop -id $1 -f $0 8s -set $0 \"$prop\"", \
                p, winid, NULL \
        } \
}

#define MODKEY Mod1Mask  /* Alt key for tab navigation (avoids conflict with dwm super bindings) */
static const Key keys[] = {
	/* modifier             key        function     argument */
	{ MODKEY|ShiftMask,     XK_Return, focusonce,   { 0 } },
	{ MODKEY|ShiftMask,     XK_Return, spawn,       { 0 } },

	{ MODKEY,               XK_Tab,    rotate,      { .i = +1 } },  /* alt+Tab: next tab */
	{ MODKEY|ShiftMask,     XK_Tab,    rotate,      { .i = -1 } },  /* alt+shift+Tab: prev tab */
	{ MODKEY|ShiftMask,     XK_j,      movetab,     { .i = -1 } },
	{ MODKEY|ShiftMask,     XK_k,      movetab,     { .i = +1 } },
	{ MODKEY|ControlMask,   XK_Tab,    rotate,      { .i = 0 } },

	{ MODKEY,               XK_grave,  spawn,       SETPROP("_TABBED_SELECT_TAB") },
	{ MODKEY,               XK_1,      move,        { .i = 0 } },
	{ MODKEY,               XK_2,      move,        { .i = 1 } },
	{ MODKEY,               XK_3,      move,        { .i = 2 } },
	{ MODKEY,               XK_4,      move,        { .i = 3 } },
	{ MODKEY,               XK_5,      move,        { .i = 4 } },
	{ MODKEY,               XK_6,      move,        { .i = 5 } },
	{ MODKEY,               XK_7,      move,        { .i = 6 } },
	{ MODKEY,               XK_8,      move,        { .i = 7 } },
	{ MODKEY,               XK_9,      move,        { .i = 8 } },
	{ MODKEY,               XK_0,      move,        { .i = 9 } },

	{ MODKEY,               XK_q,      killclient,  { 0 } },  /* alt+q: close individual tab */

	{ MODKEY,               XK_u,      focusurgent, { 0 } },
	{ MODKEY|ShiftMask,     XK_u,      toggle,      { .v = (void*) &urgentswitch } },

	{ 0,                    XK_F11,    fullscreen,  { 0 } },
};
