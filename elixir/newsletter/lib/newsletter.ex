defmodule Newsletter do
  def read_emails(path) do
    {:ok, emails} = File.read(path)
    String.split(emails, "\n", trim: true)
  end

  def open_log(path) do
    {:ok, pid} = File.open(path, [:write])
    pid
  end

  def log_sent_email(pid, email) do
    IO.write(pid, [email, "\n"])
  end

  def close_log(pid) do
    # Please implement the close_log/1 function
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    # Please implement the send_newsletter/3 function
  end
end
