defmodule Newsletter do
  def read_emails(path) do
    {:ok, emails} = File.read(path)
    String.split(emails, "\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      with :ok <- send_fun.(email) do
        log_sent_email(log, email)
      end
    end)

    close_log(log)
  end
end
