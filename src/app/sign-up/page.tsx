import Link from "next/link";

export default function SignUpPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-gradient-to-br from-background via-background to-violet-500/5">
      <div className="flex flex-col items-center gap-6 w-full max-w-sm px-4 text-center">
        <img src="/logo-light.png" alt="Praxl" className="h-10 dark:hidden" />
        <img src="/logo-dark.png" alt="Praxl" className="h-10 hidden dark:block" />
        <div className="space-y-2">
          <h1 className="text-xl font-semibold tracking-tight">Account creation is closed</h1>
          <p className="text-sm text-muted-foreground">
            This Praxl instance is invite-only. If you already have an account, sign in instead.
          </p>
        </div>
        <Link
          href="/sign-in"
          className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
        >
          Sign in
        </Link>
      </div>
    </div>
  );
}
