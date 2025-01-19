/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: filipe <filipe@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/19 13:26:23 by filipe            #+#    #+#             */
/*   Updated: 2025/01/19 13:42:58 by filipe           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk_bonus.h"

void	signal_handler(int sig, siginfo_t *info, void *context)
{
	static unsigned char	character = 0;
	static int				bits = 0;
	static pid_t			client_pid = 0;

	(void)context;
	if (client_pid != info->si_pid)
	{
		character = 0;
		bits = 0;
	}
	client_pid = info->si_pid;
	character = character << 1;
	if (sig == SIGUSR2)
		character = character | 1;
	bits++;
	if (bits == 8)
	{
		write(1, &character, 1);
		if (character == '\0')
			kill(client_pid, SIGUSR2);
		bits = 0;
		character = 0;
	}
	kill(client_pid, SIGUSR1);
}

int	main(void)
{
	struct sigaction	sa;

	ft_printf("Server PID: %d\n", getpid());
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = &signal_handler;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause();
	return (0);
}
