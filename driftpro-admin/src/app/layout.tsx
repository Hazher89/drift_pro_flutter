import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "DriftPro Admin Panel",
  description: "Admin panel for DriftPro employee management",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
} 