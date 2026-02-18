import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import BookmarksDashboard from "@/components/BookmarksDashboard";

export default async function HomePage() {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: bookmarks } = await supabase
    .from("bookmarks")
    .select("*")
    .eq("user_id", user.id)
    .order("created_at", { ascending: false });

  return (
    <BookmarksDashboard
      user={{ id: user.id, email: user.email!, name: user.user_metadata?.full_name, avatar: user.user_metadata?.avatar_url }}
      initialBookmarks={bookmarks ?? []}
    />
  );
}
