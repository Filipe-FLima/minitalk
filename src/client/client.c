/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: flima <flima@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/17 16:18:37 by flima             #+#    #+#             */
/*   Updated: 2025/01/17 20:50:08 by flima            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minitalk.h"

void	send_bit(int pid, int bit)
{
	int	signal;
	int	i;
	
	if (bit == 0)
		signal = SIGUSR1;
	else
		signal = SIGUSR2;
	i = kill(pid, signal);
	if (i == -1)
	{
		ft_putstr_fd("Error sending the signal\n", 2);
		exit(EXIT_FAILURE);
	}
	
}

void	send_char(int pid, unsigned char chr)
{
	int	bit;
	int	i;

	i = 7;
	while (i >= 0)
	{
		bit = ((chr >> i) & 1);
		send_bit(pid, bit);
		usleep(400);
		i--;
	}
}

void	send_string(int pid, char *str)
{
	if (*str == '\0')
		return;
	while (*str)
		send_char(pid, *str++);
	send_char(pid , '\0');
}

int	main(int argc, char **argv)
{
	int	pid;

	if (argc != 3)
	{
		ft_putstr_fd("Input error\nRequested input: ./client [SERVER PID] [STRING]\n", 2);
		exit(EXIT_FAILURE);
	}
	pid = ft_atoi(argv[1]);
	if (pid <= 0)
	{
		ft_putstr_fd("Error\nInvalid PID.\n", 2);
		exit(EXIT_FAILURE);
	}
	send_string(pid, argv[2]);
	return (0);
}